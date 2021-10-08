import { useRouter } from "next/dist/client/router";
import React, { useEffect, useState } from "react";
import { ChatFeed, Message } from "react-chat-ui";
import { supabase } from "../../lib/supabase";
import Image from "next/image";
import { useAuth } from "../../lib/auth";
import { searchUsers } from "../../lib/connection";

export default function GuildDetail() {
  const [messages, setmessages] = useState([]);
  const { currentUser } = useAuth();
  const [newClientText, setNewClientText] = useState("");

  const handleChange = (e) => {
    setNewClientText(e.target.value);
  };

  const fetchMessages = async () => {
    if (messages.length === 0) {
      const fetchedMessages = await supabase
        .from("messages")
        .select()
        .match({ gid: gid });

      console.log(fetchedMessages.data);

      fetchedMessages.data.map(async (message, i) => {
        const sender = await supabase
          .from("users")
          .select("username")
          .match({ uid: message.uid });

        const newText = new Message({
          id: message.mid,
          message: message.text,
          senderName: sender.data[0].username,
        });
        setmessages((messages) => [...messages, newText]);
      });
    }
  };

  const router = useRouter();
  const gid = router.query.gid;

  useEffect(() => {
    fetchMessages();
  });

  useEffect(() => {
    const subscription = supabase
      .from("messages")
      .on("INSERT", async (payload) => {
        if (payload.new.gid == gid) {
          const sender = await supabase
            .from("users")
            .select("username")
            .match({ uid: payload.new.uid });
          const newText = new Message({
            id: payload.new.mid,
            message: payload.new.text,
            senderName: sender.data[0].username,
          });
          setmessages((messages) => [...messages, newText]);
          console.log(messages);
        }
      })
      .subscribe();

    return () => subscription.unsubscribe();
  }, []);

  const handleSubmit = async () => {
    const thisUID = await supabase
      .from("users")
      .select("uid")
      .match({ email: currentUser.email });
    const newMessage = {
      gid: gid,
      text: newClientText,
      uid: thisUID.data[0].uid,
    };
    await supabase.from("messages").insert(newMessage);
    setNewClientText("");
  };

  return (
    <div className="px-60">
      <div className="mb-40">
        <ChatFeed
          messages={messages} // Array: list of message objects
          isTyping={false} // Boolean: is the recipient typing
          hasInputField={false} // Boolean: use our input, or use your own
          showSenderName
          bubblesCentered={false} //Boolean should the bubbles be centered in the feed?
          // JSON: Custom bubble styles
          bubbleStyles={{
            chatbubble: {
              borderRadius: 70,
              padding: "10 40",
              backgroundColor: "#59AF77",
            },
          }}
        />
      </div>
      <input
        value={newClientText}
        onChange={handleChange}
        placeholder="Type a message"
        className="w-9/12 fixed bottom-10 bg-accentGray rounded-xl h-14 mt-10 text-white p-4 text-lg focus:outline-none"
      />
      <div className="w-full flex justify-end">
        <div
          onClick={() => handleSubmit()}
          className="fixed flex items-center pr-3 cursor-pointer hover:opacity-70 justify-center bottom-10 float-right rounded-r-xl bg-primary-solid h-14 w-20"
        >
          <Image
            className="transform rotate-45"
            src="/send.svg"
            alt="send"
            height="30"
            width="30"
          />
        </div>
      </div>
    </div>
  );
}