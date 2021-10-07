import Link from "next/link";
import { useContext } from "react";
import { useAuth } from "../lib/auth";

export default function AuthCheck({ children, fallback = null }) {
  const { currentUser } = useAuth();
  return currentUser
    ? children
    : fallback || (
        <Link href="/signup">You must signed in to view this page</Link>
      );
}
