#!/bin/bash

#direccion del archivo
path='/etc/network/interfaces' 
#funcion para borrar todo lo que esta despues del tipo de ip del adaptador
delete () {
  sed -i '1,/iface enp0s3 inet/!d' $path
}
#funcion para usar ip dinamica
dhcp () {
  #linea para que en caso de que exista la cadena de texto static se cambie por dhcp
  sed -i 's/static/dhcp/' $path
  delete  
}
#funcion para usar ip estatica
estatico () { 
  #linea para que en caso de que exista la cadena de texto dhcp se cambien por static
  sed -i 's/dhcp/static/' $path
  delete
  #informacion sobre la red
  echo "  address 192.168.1.78/24" >> $path
  echo "gateway 192.168.1.254" >> $path
  echo "dns-nameservers 8.8.8.8" >> $path
}
#funcion para usar ip estatica 2
estatico2 () { 
  sed -i 's/dhcp/static/' $path
  delete
  echo "  address 192.168.100.25/24" >> $path
  echo "gateway 192.168.100.1" >> $path
  echo "dns-nameservers 8.8.8.8" >> $path
}
echo 'Selecciona una de las siguientes opciones'
echo '1) DHCP'
echo '2) Estatica 1'
echo '3) Estatica 2'
read -p '(1/2/3)?' opcion

case $opcion in
     1)
       dhcp;;
     2) 
       estatico;;
     3)
       estatico2;;
     *)
       echo Opcion Invalida;;
esac
/etc/init.d/networking restart
