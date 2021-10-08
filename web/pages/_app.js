import { AuthProvider } from "../lib/auth";
import "../styles/globals.css";
import "../tailwind.css";
import Navbar from "../components/Navbar";
import { Toaster } from "react-hot-toast";

function MyApp({ Component, pageProps }) {
  return (
    <AuthProvider>
      <Navbar />
      <Component {...pageProps} />
      <Toaster />
    </AuthProvider>
  );
}

export default MyApp;
