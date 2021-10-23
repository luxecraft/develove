import { AuthProvider } from "../lib/auth";
import "../styles/globals.css";
import "../tailwind.css";
import Navbar from "../components/Navbar";
import { Toaster } from "react-hot-toast";
import Footer from "../components/Footer";

function MyApp({ Component, pageProps }) {
  return (
    <AuthProvider>
      <Navbar />
      <Component {...pageProps} />
      <Footer />
      <Toaster />
    </AuthProvider>
  );
}

export default MyApp;
