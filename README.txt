# Arbax Theme (Bash Prompt)

Un tema para Bash ligero, rápido y elegante, diseñado para mejorar tu productividad con información contextual útil (Git, Python, Node, etc.).

## 🚀 Requisitos Previos (Fuentes)

Para que los iconos se visualicen correctamente, necesitas una **Nerd Font**. Si ya tienes una instalada, puedes saltar este paso. Si ves cuadrados extraños en lugar de iconos, ejecuta esto:

Copia y pega este bloque en tu terminal para instalar la fuente **Hack Nerd Font**:

```bash
# 1. Ir a temporales y descargar la fuente
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

# 2. Descomprimir en la carpeta de fuentes del usuario
unzip -o Hack.zip -d ~/.local/share/fonts

# 3. Actualizar la caché de fuentes
fc-cache -fv

echo "¡Fuente instalada! Ahora configura tu terminal para usar 'Hack Nerd Font'"