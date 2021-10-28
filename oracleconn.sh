#!/bin/bash
#Created by João Santana

export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export PATH=$PATH:$ORACLE_HOME/bin:$HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib64
export TNS_ADMIN=$ORACLE_HOME/network/admin
#Variável de controle de acesso ao banco de dados.
STR='Connected'
#Faz a conexão ao banco.
Result=$(echo "quit" |sqlplus user/pass@tnsname | grep -o 'Connected')
#Valida a conexão ao banco.
if [ -z $Result ] || [ $Result != $STR ];
then
 echo "Banco offline"
else
 #Realiza consulta com o sqlplus e retorna o valor de acordo com a fomatação nas variáveis Text e status
 Push=$(echo "quit"| echo "select * from table;" |sqlplus  user/pass@tnsname)
 Text=$(echo $Push |grep -o '\---.*'|cut -d' ' -f2-1000)
 status=${Text%SQL>*options}
 #Valida se o retorna da consulta é vazio, se não for retorna o valor 1 se for retorna o valor 0.
 #Essa parte pode ser modificada para mostrar o valor da query também
    if [[ -n $status ]]
    then
       echo '1'
    else
       echo '0'
    fi
fi
