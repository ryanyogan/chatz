defmodule Chatz.ChatTest do
  use Chatz.DataCase

  alias Chatz.Chat

  describe "chat_conversations" do
    alias Chatz.Chat.Conversation

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def conversation_fixture(attrs \\ %{}) do
      {:ok, conversation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_conversation()

      conversation
    end

    test "list_chat_conversations/0 returns all chat_conversations" do
      conversation = conversation_fixture()
      assert Chat.list_chat_conversations() == [conversation]
    end

    test "get_conversation!/1 returns the conversation with given id" do
      conversation = conversation_fixture()
      assert Chat.get_conversation!(conversation.id) == conversation
    end

    test "create_conversation/1 with valid data creates a conversation" do
      assert {:ok, %Conversation{} = conversation} = Chat.create_conversation(@valid_attrs)
      assert conversation.title == "some title"
    end

    test "create_conversation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_conversation(@invalid_attrs)
    end

    test "update_conversation/2 with valid data updates the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{} = conversation} = Chat.update_conversation(conversation, @update_attrs)
      assert conversation.title == "some updated title"
    end

    test "update_conversation/2 with invalid data returns error changeset" do
      conversation = conversation_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_conversation(conversation, @invalid_attrs)
      assert conversation == Chat.get_conversation!(conversation.id)
    end

    test "delete_conversation/1 deletes the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{}} = Chat.delete_conversation(conversation)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_conversation!(conversation.id) end
    end

    test "change_conversation/1 returns a conversation changeset" do
      conversation = conversation_fixture()
      assert %Ecto.Changeset{} = Chat.change_conversation(conversation)
    end
  end

  describe "chat_conversation_members" do
    alias Chatz.Chat.ConversationMember

    @valid_attrs %{owner: true}
    @update_attrs %{owner: false}
    @invalid_attrs %{owner: nil}

    def conversation_member_fixture(attrs \\ %{}) do
      {:ok, conversation_member} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_conversation_member()

      conversation_member
    end

    test "list_chat_conversation_members/0 returns all chat_conversation_members" do
      conversation_member = conversation_member_fixture()
      assert Chat.list_chat_conversation_members() == [conversation_member]
    end

    test "get_conversation_member!/1 returns the conversation_member with given id" do
      conversation_member = conversation_member_fixture()
      assert Chat.get_conversation_member!(conversation_member.id) == conversation_member
    end

    test "create_conversation_member/1 with valid data creates a conversation_member" do
      assert {:ok, %ConversationMember{} = conversation_member} = Chat.create_conversation_member(@valid_attrs)
      assert conversation_member.owner == true
    end

    test "create_conversation_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_conversation_member(@invalid_attrs)
    end

    test "update_conversation_member/2 with valid data updates the conversation_member" do
      conversation_member = conversation_member_fixture()
      assert {:ok, %ConversationMember{} = conversation_member} = Chat.update_conversation_member(conversation_member, @update_attrs)
      assert conversation_member.owner == false
    end

    test "update_conversation_member/2 with invalid data returns error changeset" do
      conversation_member = conversation_member_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_conversation_member(conversation_member, @invalid_attrs)
      assert conversation_member == Chat.get_conversation_member!(conversation_member.id)
    end

    test "delete_conversation_member/1 deletes the conversation_member" do
      conversation_member = conversation_member_fixture()
      assert {:ok, %ConversationMember{}} = Chat.delete_conversation_member(conversation_member)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_conversation_member!(conversation_member.id) end
    end

    test "change_conversation_member/1 returns a conversation_member changeset" do
      conversation_member = conversation_member_fixture()
      assert %Ecto.Changeset{} = Chat.change_conversation_member(conversation_member)
    end
  end
end
