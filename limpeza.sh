#!/bin/zsh
#Limpar o sistema
#Refazer todo Script

echo "Tokem atualizado 21 de março"
echo "##############################################################"
echo "##                                                          ##"
echo "##                     Limpar o sistema                     ##"
echo "##                           vamos                          ##"
echo "##############################################################"
echo " "
echo " "
echo "##############################################################"
echo "##                                                          ##"
echo "##             Limpar o Systemd - coredumps                 ##"
echo "##                                                          ##"
echo "##############################################################"
echo " "
echo " "

echo "Pressione 's' para Sim, 'n' para Não ou qualquer outra tecla para sair."
#stty -echo # Desliga o eco da entrada do usuário
read -n resposta
stty echo # Liga o eco da entrada do usuário
case "$resposta" in
    s|S)
        echo "" # Adiciona uma quebra de linha após a entrada para "Sim"
        if output=$(rm -fr /var/lib/systemd/coredump/* 2>/dev/null); then
            echo "Arquivos removidos."
        else
            if [[ "$output" != *"No such file or directory"* ]]; then
                echo "Não existem arquivos para remover."
                echo "Nada a fazer."
            fi
    fi ;;
    n|N)
    echo "Próximo comando a ser executado" ;;
    *)
    exit 0 ;;
esac

for i in {1..10}; do
    echo -n "######"
    sleep 0.5
done
#Procurando estabelecer o padrão de pergunta e resposta
#echo "Pressione 's' para Sim, 'n' para Não ou qualquer outra tecla para sair."
#read resposta1
#case "$resposta1" in
#  s|S) rm /var/lib/systemd/coredump/* >/dev/null 2>&1 ;;
#  n|N) echo "proximo comando para ser executado" ;;
#  *) exit 0 ;;
#esac
#    for i in {1..10}; do
#        echo -n "######"
#        sleep 0.5
#    done
#read resp
#if [ $resp. != 's.' ]; then
#	exit 0
#fi
#rm /var/lib/systemd/coredump/*
echo " "
echo " "
echo "##############################################################"
echo "##                                                          ##"
echo "##  Colocando o tempo de armazenamento de logs para 2 dias  ##"
echo "##                                                          ##"
echo "##############################################################"
echo " "
echo " "
echo "Pressione 's' para Sim, 'n' para Não ou qualquer outra tecla para sair."
read resposta2
case "$resposta2" in
    s|S) journalctl --vacuum-time=2d >/dev/null 2>&1/* ;;
    n|N) echo "proximo comando para ser executado" ;;
    *) exit 0 ;;
esac
for i in {1..10}; do
    echo -n "######"
    sleep 0.5
done
#echo "Digite s para continuar ou qualquer outra coisa para terminar"
#read resp
#if [ $resp. != 's.' ]; then
#    exit 0
#fi
#journalctl --vacuum-time=2d >/dev/null 2>&1

echo " "
echo " "
echo "##############################################################"
echo "##                                                          ##"
echo "##          Atribuindo espaço mínimo para logs              ##"
echo "##                                                          ##"
echo "##############################################################"
echo " "
echo " "
echo "Pressione 's' para Sim, 'n' para Não ou qualquer outra tecla para sair."
read resposta3
case "$resposta3" in
    s|S) journalctl --vacuum-size=500M >/dev/null 2>&1/* ;;
    n|N) echo "proximo comando para ser executado" ;;
    *) exit 0 ;;
esac
for i in {1..10}; do
    echo -n "######"
    sleep 0.5
done
#echo "Digite s para continuar ou qualquer outra coisa para terminar"
#read resp
#if [ $resp. != 's.' ]; then
#    exit 0
#fi
#journalctl --vacuum-size=500M
echo " "
echo " "
echo "##############################################################"
echo "##                                                          ##"
echo "##       Flatpaks não usados seram desisntalados            ##"
echo "##                                                          ##"
echo "##############################################################"
echo " "
echo " "
echo "Pressione 's' para Sim, 'n' para Não ou qualquer outra tecla para sair."
read resposta4
case "$resposta4" in
    s|S)  flatpak uninstall --unused>/dev/null 2>&1/* ;;
    n|N) echo "proximo comando para ser executado" ;;
    *) exit 0 ;;
esac
for i in {1..10}; do
    echo -n "######"
    sleep 0.5
done
#echo "Digite s para continuar ou qualquer outra coisa para terminar"
#read resp
#if [ $resp. != 's.' ]; then
#    exit 0
#fi
#flatpak uninstall --unused
echo " "
echo " "
echo "##############################################################"
echo "##                                                          ##"
echo "##        Limpar cache/buffer, dentries e inodes            ##"
echo "##                                                          ##"
echo "##############################################################"
echo " "
echo " "
echo "Pressione 's' para Sim, 'n' para Não ou qualquer outra tecla para sair."
read resposta5
case "$resposta5" in
    s|S)  sync; echo 3 > /proc/sys/vm/drop_caches ;;
    n|N) echo "proximo comando para ser executado" ;;
    *) exit 0 ;;
esac
for i in {1..10}; do
    echo -n "######"
    sleep 0.5
done
#echo "Digite s para continuar ou qualquer outra coisa para terminar"
#read resp
#if [ $resp. != 's.' ]; then
#    exit 0
#fi
#sync; echo 3 > /proc/sys/vm/drop_caches
echo " "
echo " "
echo "##############################################################"
echo "##                                                          ##"
echo "##       Limpar o espaço em disco consumido pelo SWAP       ##"
echo "##                                                          ##"
echo "##############################################################"
echo " "
echo " "
echo "se não tiver memória o suficiente vai travar..."
echo " "
echo " "
echo "Digite s para continuar ou qualquer outra coisa para terminar"
read resp
if [ $resp. != 's.' ]; then
    exit 0
fi
swapoff -a && swapon -a
echo "--------------------"
echo "--------------------"
echo "Remove todos os pacotes do sistema que foram originalmente instalados "
echo "como dependências de outros pacotes instalados pelo usuário, mas que não são mais exigido por outros programas."
echo "Digite s para continuar ou qualquer outra coisa para terminar"
read resp
if [ $resp. != 's.' ]; then
    exit 0
fi
dnf autoremove

echo "Executa a limpeza de arquivos temporários mantidos para repositórios. "
echo "Isso inclui quaisquer dados deixados por trás de repositórios desativados ou removidos"
echo "bem como para diferentes versões de lançamento de distribuição."
echo "Digite s para continuar ou qualquer outra coisa para terminar"
read resp
if [ $resp. != 's.' ]; then
    exit 0
fi
dnf clean dbcache

echo "Remove arquivos de cache gerados a partir dos metadados do repositório."
echo "Isso força o DNF a regenerar os arquivos de cache na próxima vez que ele for executado."
echo "Digite s para continuar ou qualquer outra coisa para terminar"
read resp
if [ $resp. != 's.' ]; then
    exit 0
fi
dnf clean expire-cache

echo "Remove metadados do repositório."
echo "Digite s para continuar ou qualquer outra coisa para terminar"
read resp
if [ $resp. != 's.' ]; then
    exit 0
fi
dnf clean packages

echo "Atualiza o sistema todo a partir dos repositórios habilitados."
echo "Digite s para continuar ou qualquer outra coisa para terminar"
read resp
if [ $resp. != 's.' ]; then
    exit 0
fi
dnf distro-sync

#Exibe um histórico do que foi feito pelo dnf
#dnf history
