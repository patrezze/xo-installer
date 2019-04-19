# Xen Orchestra Installer

Este script instala o Xen Orchestra a partir dos códigos fontes [xen-orchestra](https://github.com/vatesfr/xen-orchestra).

Durante o processo as dependências necessárias são instaladas e os fontes são compilados. Além disso, o serviço é habilitado e iniciado.

> O procedimento foi testado no **Debian Stretch** e suporta distribuíções Linux baseadas no [Debian](https://www.debian.org).

Por padrão, o script instala o Xen Orchestra no diretório `/opt`.

## Instalando o Xen Orchestra

Clone o repositório.

```
git clone https://github.com/patrezze/xo-installer.git
```

Execute como `root` os seguintes comandos.

```
# chmod +x xo-installer/install.sh
# xo-installer/install.sh
```

Ao final do processo, é esperando o seguinte resultado.

```
● xo-server.service - XO Server
   Loaded: loaded (/etc/systemd/system/xo-server.service; enabled; vendor preset: en
   Active: active (running) since Fri 2019-04-19 18:21:49 -03; 356ms ago
 Main PID: 14514 (node)
    Tasks: 6 (limit: 4915)
   CGroup: /system.slice/xo-server.service
           └─14514 /usr/bin/node ./bin/xo-server

abr 19 18:21:49 xo systemd[1]: Started XO Server.

Xen Orchestra installed
Default user: "admin@admin.net" with password "admin"

```

## Referências
* [Instalando o Xen Orquestra a partir do código fonte.](https://xen-orchestra.com/docs/from_the_sources.html).
* As instruções para instalar o NodeJS estão [aqui](https://nodejs.org/en/download/package-manager/).
* Procedimento para instalação do Yarn pode ser obtido [nesta página](https://yarnpkg.com/en/docs/install).
