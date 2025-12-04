# Arbax Theme (Bash Prompt)

Un tema para Bash ligero, rápido y elegante, diseñado para mejorar tu
productividad con información contextual útil (Git, Python, Node, etc.).

## Requisitos Previos (Fuentes)

Para que los iconos se visualicen correctamente, necesitas una **Nerd
Font**. Si ya tienes una instalada, puedes saltar este paso. Si ves
cuadrados extraños en lugar de iconos, ejecuta esto:

``` bash
# 1. Ir a temporales y descargar la fuente
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

# 2. Descomprimir en la carpeta de fuentes del usuario
unzip -o Hack.zip -d ~/.local/share/fonts

# 3. Actualizar la caché de fuentes
fc-cache -fv

echo "¡Fuente instalada! Ahora configura tu terminal para usar 'Hack Nerd Font'"
```

## 1. Descargar el tema

Puedes usar curl o wget. El archivo se guardará como `~/Arbax.sh`.

### Opción con cURL (Recomendado):

``` bash
curl -o ~/Arbax.sh https://raw.githubusercontent.com/elberav/projets_scrips/main/Arbax_.723.next.line.sh
```

### Opción con Wget:

``` bash
wget -O ~/Arbax.sh https://raw.githubusercontent.com/elberav/projets_scrips/main/Arbax_.723.next.line.sh
```

## 2. Activar el tema

Una vez descargado, necesitas decirle a tu terminal que lo cargue cada
vez que la abras. Ejecuta estos dos comandos:

``` bash
# Agrega la carga del script a tu archivo de configuración .bashrc
echo 'source ~/Arbax.sh' >> ~/.bashrc

# Recarga la configuración para ver los cambios inmediatamente
source ~/.bashrc
```

## Recomendaciones de Configuración

-   **Colores**: Usa una terminal que soporte True Color (24-bit) o al
    menos 256 colores.
-   **Fondo**: Se recomienda un fondo oscuro para resaltar los colores
    brillantes del tema.
-   **Fuente**: Recuerda seleccionar *Hack Nerd Font* (o cualquier Nerd
    Font de tu preferencia) en las opciones de tu emulador de terminal.
