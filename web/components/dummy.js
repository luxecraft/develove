import { useAuth } from "../lib/auth";
import styles from "../styles/Home.module.css";
export function Dummy() {
  const auth = useAuth();

  return (
    <div>
      <div className={styles.container}>
        {auth.currentUser !== null ? null : (
          <button onClick={() => auth.signUpWithGoogle()}>
            Sign Up with Google
          </button>
        )}
        {auth.currentUser !== null ? null : (
          <button onClick={() => auth.signUpWithGithub()}>
            Sign Up with Github
          </button>
        )}
        <p>{auth.currentUser !== null ? auth.currentUser.email : null}</p>
      </div>
    </div>
  );
}
