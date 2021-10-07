import { useRouter } from "next/dist/client/router";
import React, { useEffect } from "react";

export default function Explore() {
  const router = useRouter();
  useEffect(() => {
    router.push("explore/people");
  }, [router]);
  return <div></div>;
}
