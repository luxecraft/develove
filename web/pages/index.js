import { AuthProvider } from "../lib/auth";
import { Dummy } from "../components/dummy";

export default function Home() {
  return (
    <AuthProvider>
      <Dummy />
    </AuthProvider>
  );
}
