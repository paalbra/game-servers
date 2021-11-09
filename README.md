# Game servers

## Counter Strike 1.6

```
cd dockerfiles/cs
podman build -t cs .
podman run -d --name cs -p 27015:27015 cs de_train normal
podman logs -f cs
```
