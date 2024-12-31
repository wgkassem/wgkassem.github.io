# Description

Personal website, blog, and logbook.
Sharing my thoughts, ideas, and projects.

# Dependencies

- npm
- git

## Loose dependencies

- [forked icarus theme](https://wgkassem.github.com/hexo-theme-icarus)
- More can be found in [package.json](./package.json)

# Building and running

```bash
docker compose up -d --build
# go to http://localhost
``````

# Development


```bash
docker compose -f .devcontainer/compose.yml up -d --build
docker compose -f ./devcontainer/compose.yml exec sh
npm ci  # or npm install
npm run build
```

git-commit any changes to source or dependencies.
See [reproducible builds](./source/_posts/npm_force_install.md).
