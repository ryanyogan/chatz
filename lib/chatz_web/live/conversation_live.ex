defmodule ChatzWeb.ConversationLive do
  require Logger
  use ChatzWeb, :live_view

  alias Chatz.{Auth, Chat, Repo}
  alias ChatzWeb.ConversationView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ConversationView.render("show.html", assigns)
  end

  @impl true
  def handle_params(
        %{"conversation_id" => conversation_id, "user_id" => user_id},
        _url,
        socket
      ) do
    ChatzWeb.Endpoint.subscribe("conversation_#{conversation_id}")

    {:noreply,
     socket
     |> assign(:user_id, user_id)
     |> assign(:conversation_id, conversation_id)
     |> assign_records()}
  end

  defp assign_records(%{assigns: %{user_id: user_id, conversation_id: conversation_id}} = socket) do
    user = Auth.get_user!(user_id)

    conversation =
      Chat.get_conversation!(conversation_id)
      |> Repo.preload(messages: [:user], conversation_members: [:user])

    socket
    |> assign(:user, user)
    |> assign(:conversation, conversation)
    |> assign(:messages, conversation.messages)
  end

  @impl true
  def handle_event(
        "send_message",
        %{"message" => %{"content" => content}},
        %{assigns: %{conversation_id: conversation_id, user_id: user_id, user: user}} = socket
      ) do
    case Chat.create_message(%{
           conversation_id: conversation_id,
           user_id: user_id,
           content: content
         }) do
      {:ok, new_message} ->
        new_message = %{new_message | user: user}

        ChatzWeb.Endpoint.broadcast!(
          "conversation_#{conversation_id}",
          "new_message",
          new_message
        )

        {:noreply, socket}

      {:error, err} ->
        Logger.error(inspect(err))
        {:noreply, socket}
    end
  end

  @impl true
  def handle_info(%{event: "new_message", payload: new_message}, socket) do
    updated_messages = [new_message | socket.assigns.messages]

    {:noreply, socket |> assign(:messages, updated_messages)}
  end
end
