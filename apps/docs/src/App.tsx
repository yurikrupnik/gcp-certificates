import logo from "./logo.svg";
import styles from "./App.module.css";

function App() {
  return (
    <div class={styles.App}>
      <div>
        steps:
      </div>
      <div>
        1. create service account with artifact registy role
      </div>
      <div>
        2. turn on artifact registy
      </div>
      <div>
        3. create artifact repository
      </div>
      <header class={styles.header}>
        <img src={logo} class={styles.logo} alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          class={styles.link}
          href="https://github.com/solidjs/solid"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn Solid
        </a>
      </header>
    </div>
  );
}

export default App;
