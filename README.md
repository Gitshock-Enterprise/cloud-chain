<div align=center>
 
# Cloud Chain Web Version
With Cloud CChain Web Version you can manage your data storage in your browser.

</div>

## Examples
Here are some examples of what you can do with Cloud-Chain Web:
- 🗂 **Files**: Upload, download, search and manage files (as you may know it for example from Dropbox, OneDrive, Google Drive etc.).
- 👥 **Share:** Allow fine-grained access to files and whole folders directly with other users on your Cloud-Chain.
- 🔗 **Links**: Create links and share them with anyone in the world - optional password-protection available.
- 📝 **Write**: Edit your documents with the editor of your choice like ONLYOFFICE, Collabora or Microsoft Word and more.
- 🤝 **Collaborate** in real-time on documents.
- 🚀 **Spaces**: You have to manage important projects? Let Spaces, the new special folders, keep order. 
- ◀️ **Versioning** Saved the wrong version? We have the time machine you were looking for! Easily go back in time and restore older versions of your files.
- 📥 **Drop-folders:** Collect files from other people in one folder via a simple link, ex. homework from pupils or photos from your family - optional password-protection available.
- 🔒 **Privacy first:** Cloud-Chain Web is GDPR compliant and can both be used completely internally or together with external people. It also will never "phone home".
- ♿ **Inclusive:** Our goal is to be accessible for kids as well as seniors and for newbies as well as experts - since we are all affected by physical and cognitive limitations, depending on our personal situation.
- 🧩 **Extensible:** Cloud-Chain Web is build as a plattform that can be extended in the most developer friendly way.
- 🌗 **Darkmode:** Initialized with your browser settings, and easily switched to please your eyes better.
- 🎭 **Themes**: Customize to your branding needs or personal taste in no time.
- 👉 and many more...

As the successor to the classic Cloud-Chain frontend, it is compatible with both. When used with the Cloud-Chain Server, Cloud-Chain Web is made available to users via an additional item "New Design" in the application switcher. 

While the `web` frontend provides a performant, elegant, accessible and themeable base, it also aims to be extendable with custom extensions provided by external developers.


## Repository structure

The backbone of this project is built by the following parts of the `packages`:
- **client:** Generated TypeScript client for communications with the Cloud-Chain Infinite Scale graph API
- **container:** Static assets and rarely changing base files
- **integration-oc10:** Small PHP building blocks to make `web` work as an app with the Cloud-Chain Server
- **pkg:** Shared logic for various places inside the codebase
- **runtime:** Central place of (user) authentication, provisioning of the user interface layout, client side storage, routing, theming, dependencies and (sub)application handling

The repository's `packages` also contains the following apps, which can be en-/disabled via the `config.json`:
- **draw-io:** An extension for creating, opening and editing `.draw` files
- **external:** An extension for creating, opening and editing files using the WOPI server
- **files:** The default extension and core part of the project, responsible for file sync-and-share - up- and downloading, sharing with other users/groups or via links, version management and more
- **pdf-viewer:** An extension for opening PDF files without leaving the UI
- **preview:** An extension for opening audio, video and image files
- **search:** An extension for registering search providers, which then get rendered into the layout in the **runtime** using a portal
- **skeleton:** Bare extension serving as a playground for prototyping new custom extensions
- **text-editor:** An extension for creating, opening and editing plain text files, like e.g. `.md` or `.txt`
- **user-management:** An extension for basic user and group management by the admin. Only works with the Infinite Scale platform, as it uses the graph API.
