<table align="center">
  <thead>
    <tr >
      <th colspan="2" style="text-align:center"><b>Comandos Assembler<b></th> 
    </tr>
    <tr>
      <th style="text-align:center">Nombre</th>
      <th style="text-align:center">Definición</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td></td>
      <td></td>
    </tr>
    <tr><td colspan="2" style="text-align:center"><i><b>Traslado de datos</td></tr>
    <tr>
      <td>mov</td>
      <td>Mueve de un origen a un destino</td>
    </tr>
        <tr>
      <td>mvn</td>
      <td>Negación de los bit <b>"not"</b></td>
    </tr>
    <tr><td colspan="2" style="text-align:center"><i><b>Comparaciones</td></tr>
    <tr>
      <td>cmp</td>
      <td>Compara el 1er y 2o operador, deja resultado en el SR</td>
    </tr>
    <tr>
      <td>cmn</td>
      <td>Compara el 1er y la negación del 2º operador, deja resultado en el SR</td>
    </tr>
    <tr><td colspan="2" style="text-align:center"><i><b>Calculo de enteros</td></tr>
    <tr>
      <td>add</td>
      <td>+</td>
    </tr>
        <tr>
      <td>sub</td>
      <td>-</td>
    </tr>
    <tr>
      <td>rsb</td>
      <td>- (orden inverso)</td>
    </tr>
    <tr>
      <td>eor</td>
      <td>"^" (XOR)</td>
    </tr>
    <tr>
      <td>orr</td>
      <td>"|" (OR)</td>
    </tr>
    <tr>
      <td>and</td>
      <td>& (AND)</td>
    </tr>
    <tr>
      <td>bic</td>
      <td>&~ (AND NOT)</td>
    </tr>
    <tr>
      <td>adc</td>
      <td>+ con carry</td>
    </tr>
    <tr>
      <td>sbc</td>
      <td>- con carry</td>
    </tr>
    <tr><td colspan="2" style="text-align:center"><i><b>Saltos</td></tr>
    <tr>
      <td>beq</td>
      <td>Saltar si son iguales</td>
    </tr>
    <tr>
      <td>bne</td>
      <td>Saltar si son diferentes</td>
    </tr>
    <tr>
      <td>bgt</td>
      <td>Saltar si es mayor (signed int)</td>
    </tr>
    <tr>
      <td>blt</td>
      <td>Saltar si es menor (signed int)</td>
    </tr>
    <tr>
      <td>bge</td>
      <td>Saltar si es mayor o igual (signed int)</td>
    </tr>
    <tr>
      <td>ble</td>
      <td>Saltar si es menor o igual (signed int)</td>
    </tr>
    <tr>
      <td>bhi</td>
      <td>Saltar si es mayor que (unsigned int)</td>
    </tr>
    <tr>
      <td>bhs</td>
      <td>Saltar si es mayor o igual que (unsigned int)</td>
    </tr>
    <tr>
      <td>blo</td>
      <td>Saltar si es menor que (unsigned int)</td>
    </tr>
    <tr>
      <td>bls</td>
      <td>Saltar si es menor o igual que (unsigned int)</td>
    </tr>
    <tr>
      <td>bmi</td>
      <td>Saltar si es negativo</td>
    </tr>
    <tr>
      <td>bpl</td>
      <td>Saltar si es positivo (0 incluido)</td>
    </tr>
    <tr><td colspan="2" style="text-align:center"><i><b>Leer</td></tr>
    <tr>
      <td>ldrb</td>
      <td>Unsigned char (8 bits)</td>
    </tr>
    <tr>
      <td>ldrsb</td>
      <td>Signed char (8 bits y extender el signo a los 24 restantes)</td>
    </tr>
    <tr>
      <td>ldrh</td>
      <td>Unsigned short (16 bits)</td>
    </tr>
        <tr>
      <td>ldrsh</td>
      <td>Signed short (16 bits y extender signo a los 16 restantes)</td>
    </tr>    
    <tr>
      <td>ldr</td>
      <td>Signed y Unsigned int (32 bits)</td>
    </tr>
    <tr><td colspan="2" style="text-align:center"><i><b>Escribir</td></tr>
    <tr>
      <td>strb</td>
      <td>Escribir 8 bits</td>
    </tr>
    <tr>
      <td>strh</td>
      <td>Escribir 16 bits</td>
    </tr>
    <tr>
      <td>str</td>
      <td>Escribir 32 bits</td>
    </tr>
        <tr><td colspan="2" style="text-align:center"><i><b>Prologo</td></tr>
    <tr>
      <td>stmdb sp! {rn}</td>
      <td>Reserva registros extra (4-14)</td>
    </tr> 
    <tr><td colspan="2" style="text-align:center"><i><b>Epilogo</td></tr>
    <tr>
      <td>ldmia sp! {rn}</td>
      <td>Libera los registros reservados en el prologo</td>
    </tr>
    <tr>
      <td>bx</td>
      <td>Salto para terminar el programa</td>
    </tr>    
  </tbody>
</table>
