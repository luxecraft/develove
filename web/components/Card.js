import React from "react";

export default function Card({ content, size }) {
  return (
    <div className="bg-accentGray flex-grow h-48 rounded-xl shadow-lg p-10 text-white font-medium">
      {content}
    </div>
  );
}
