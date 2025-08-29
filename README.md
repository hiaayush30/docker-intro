### 🔹 1. Why `nvm` doesn’t “stick” across `RUN`s in Docker

* Each `RUN` instruction in a Dockerfile **creates a new container layer** with a **new shell session**.
* `nvm` works by modifying your **current shell’s environment variables** (`PATH`, `NVM_DIR`, etc.) when you `source ~/.nvm/nvm.sh`.
* But once that `RUN` ends, the shell session is gone.
  So the next `RUN` starts fresh, without those variables.

👉 Example:

```dockerfile
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN . "$HOME/.nvm/nvm.sh" && nvm install 22
```

The second `RUN` starts a **new shell** that doesn’t know about `nvm.sh` from the first step → so `nvm` command isn’t found.
That’s why you usually have to either:

* combine everything in **one `RUN`**, or
* set `ENV PATH=...` manually to point to the installed Node.

---

### 🔹 2. What happens if you do `FROM node` instead of `FROM node:22`?

* `FROM node` means **“give me the latest stable Node.js version available at build time”**.
* Today (Aug 2025), that’s **Node 22**. But when Node 23 or 24 releases, `FROM node` will suddenly pull that newer version.
* This can **break your app** if the new Node version introduces breaking changes.

👉 Example:

* Today → `FROM node` = Node 22
* A year later → `FROM node` = Node 24
* If your code isn’t compatible with Node 24, your Docker build fails.

That’s why best practice is:

* Use a **pinned version** (`FROM node:22`) for consistency in production.
* Use `FROM node` only if you’re okay with always testing on the latest Node.

---

⚡ TL;DR:

* `nvm` doesn’t persist because every `RUN` is a new shell.
* `FROM node` = latest Node (may change unexpectedly).
* `FROM node:22` = fixed Node 22 (stable, predictable).

---

Do you want me to also show you **how to verify which Node version your container actually runs** after build?
