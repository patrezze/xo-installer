# Xen Orchestra Installer

Este script instala o Xen Orchestra a partir dos códigos fontes [XO-Server](https://github.com/vatesfr/xo-server) e [XO-Web](https://github.com/vatesfr/xo-web).

Durante o processo as dependências necessárias são instaladas e os fontes são compilados. Além disso, o serviço é habilitado e iniciado.

> O procedimento foi testado no **Debian Jessie** e suporta distribuíções Linux baseadas no [Debian](https://www.debian.org).

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
   Loaded: loaded (/etc/systemd/system/xo-server.service; enabled)
   Active: active (running) since Tue 2017-03-28 00:12:20 -03; 9h ago
 Main PID: 456 (node)
   CGroup: /system.slice/xo-server.service
           └─456 /usr/local/bin/node ./bin/xo-server
```

## Referências
* [Instalando o Xen Orquestra a partir do código fonte.](https://xen-orchestra.com/docs/from_the_sources.html)
* Procedimento para instalação do Yarn pode ser obtido [nesta página](https://yarnpkg.com/en/docs/install).
