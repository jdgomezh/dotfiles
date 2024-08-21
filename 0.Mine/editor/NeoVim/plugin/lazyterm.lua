-- lazyterm.lua - Configuración para la terminal flotante con LazyVim.

-- Define el módulo principal del plugin
local plugin = {}

-- Especifica el plugin de la terminal
plugin[1] = 'LazyVim/LazyVim'

-- Configura las opciones de la terminal flotante
plugin.opts = function(_, opts)
    -- Configura LazyTerm para usar una ventana flotante centrada
    opts.terminal = opts.terminal or {}
    opts.terminal.float = {
        enabled = true,  -- Habilita la ventana flotante
        open_cmd = 'botright vnew',  -- Comando para abrir la ventana flotante
        border = 'rounded',  -- Tipo de borde: rounded, single, double, etc.
        width = 0.8,  -- Ancho de la ventana flotante en porcentaje del ancho total de la pantalla
        height = 0.8,  -- Alto de la ventana flotante en porcentaje del alto total de la pantalla
        winblend = 10,  -- Transparencia de la ventana
        zindex = 50,  -- Z-index para la capa de la ventana flotante
        highlights = {
            border = 'FloatBorder',  -- Resaltar el borde con el grupo de resaltado 'FloatBorder'
            background = 'NormalFloat',  -- Fondo de la ventana flotante
        },
    }
end

-- Retorna la configuración completa del plugin
return plugin
