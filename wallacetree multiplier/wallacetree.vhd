----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:49:26 04/03/2019 
-- Design Name: 
-- Module Name:    wallacetree - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-------------------------------------------------------
entity full_adder is
port (
a:in std_logic;
b: in std_logic;
cin:in std_logic;
sum:out std_logic;
cout:out std_logic
); 											--------------@SHREYANSHU KUMAR IIT JAMMU
end full_adder;

architecture Behavioral of full_adder is

begin

sum<=(a xor b) xor cin;
cout<= ((a xor b) and cin) or (a and b);
end Behavioral;
------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity bitadder8 is 
port(
a:in std_logic_vector(7 downto 0);
b:in std_logic_vector(7 downto 0);
cin:in std_logic;
sum:out std_logic_vector(7 downto 0);
carry:out std_logic
);
end bitadder8;
architecture Behavioral of bitadder8 is
signal s0,s1,s2,s3,s4,s5,s6,s7,c0,c1,c2,c3,c4,c5,c6,c7:std_logic;

begin
bit0 : ENTITY WORK.full_adder
	port map (a => a(0),b =>b(0),cin => cin,sum => sum(0), cout=> c0);
	
bit1 : ENTITY WORK.full_adder
	port map (a => a(1),b =>b(1),cin => c0,sum => sum(1), cout=> c1);

bit2 : ENTITY WORK.full_adder
	port map (a => a(2),b =>b(2),cin => c1,sum => sum(2), cout=> c2);

bit3 : ENTITY WORK.full_adder
	port map (a => a(3),b =>b(3),cin => c2,sum => sum(3), cout=> c3);

bit4 : ENTITY WORK.full_adder
	port map (a => a(4),b =>b(4),cin => c3,sum => sum(4), cout=> c4);

bit5 : ENTITY WORK.full_adder
	port map (a => a(5),b =>b(5),cin => c4,sum => sum(5), cout=> c5);

bit6 : ENTITY WORK.full_adder
	port map (a => a(6),b =>b(6),cin => c5,sum => sum(6), cout=> c6);
	
bit7 : ENTITY WORK.full_adder
	port map (a => a(7),b =>b(7),cin => c6,sum => sum(7), cout=> carry);


end Behavioral;
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity wallacetree is
port(
ai:in std_logic_vector(7 downto 0);
bi:in std_logic_vector(7 downto 0);
ci:out std_logic_vector(15 downto 0)

);
end wallacetree;

architecture Behavioral of wallacetree is
signal p0,p1,p2,p3,p4,p5,p6,p7,c1,c2,s3,c3,c4,c5:std_logic_vector(7 downto 0);
signal s1,s2,s5,c6:std_logic_vector(9 downto 0);
signal s4:std_logic_vector(12 downto 0);
signal s6,s7:std_logic_vector(14 downto 0);
signal c7:std_logic_vector(10 downto 0);
signal anew,bnew:std_logic_vector(15 downto 0);
signal cn1,cn2:std_logic;
begin
process(ai,bi)
begin
for i in 0 to 7 loop
p0(i)<=ai(i) and bi(0);
p1(i)<=ai(i) and bi(1);
p2(i)<=ai(i) and bi(2);
p3(i)<=ai(i) and bi(3);
p4(i)<=ai(i) and bi(4);
p5(i)<=ai(i) and bi(5);
p6(i)<=ai(i) and bi(6);
p7(i)<=ai(i) and bi(7);
end loop;
end process;
-----------p0,p1,p2 sum and carry calculation
process(p0,p1,p2)
begin 
s1(0)<=p0(0);
s1(1)<=p0(1) xor p1(0);
c1(0)<=p0(1) and  p1(0);

for i in 2 to 7 loop
s1(i)<=(p0(i) XOR p1(i-1)) XOR p2(i-2);
c1(i-1)<=(p0(i) AND p1(i-1)) OR (p2(i-2)and (p0(i) XOR p1(i-1)));
end loop;
s1(8)<=p1(7) xor p2(6);
s1(9)<= p2(7);
c1(7)<=p1(7) and  p2(6);
end process;
---------------p3,p4,p5 sum and carry calculation
process(p3,p4,p5)
begin 
s2(0)<=p3(0);
s2(1)<=p3(1) xor p4(0);
c2(0)<=p3(1) and  p4(0);

for i in 2 to 7 loop
s2(i)<=(p3(i) XOR p4(i-1)) XOR p5(i-2);
c2(i-1)<=(p3(i) AND p4(i-1)) OR (p5(i-2)and (p3(i) XOR p4(i-1)));
end loop;
s2(8)<=p4(7) xor p5(6);
s2(9)<= p5(7);
c2(7)<=p4(7) and  p5(6);
end process;
----------------------------s3 and c3 same as p6 and p7 respectively
process(p6,p7)
begin 
s3<=p6;
c3<=p7;
end process;
----------------------calculating s4 and c4
process(s1,c1,s2)
begin
s4(1 downto 0)<= s1(1 downto 0);
s4(2)<=s1(2) xor c1(0);
c4(0)<=s1(2) and c1(0);
for i in 3 to 9 loop
s4(i)<=(s1(i) XOR c1(i-2)) XOR s2(i-3);
c4(i-2)<=(s1(i) AND c1(i-2)) OR (s2(i-3)and (s1(i) XOR c1(i-2)));
end loop;
s4(12 downto 10)<=s2(9 downto 7);
end process;
------------------------calculating s5 and c5
process(c2,s3,c3)
begin 
s5(0)<=c2(0);
s5(1)<=c2(1) xor s3(0);
c5(0)<=c2(1) and  s3(0);

for i in 2 to 7 loop
s5(i)<=(c2(i) XOR s3(i-1)) XOR c3(i-2);
c5(i-1)<=(c2(i) AND s3(i-1)) OR (c3(i-2)and (c2(i) XOR s3(i-1)));
end loop;
s5(8)<=s3(7) xor c3(6);
s5(9)<= c3(7);
c5(7)<=s3(7) and  c3(6);
end process;
----------------------------------- now calculating s6 and c6
process(s4,c4,s5)
begin
s6(2 downto 0)<= s4(2 downto 0);
s6(3)<=s4(3) xor c4(0);
c6(0)<=s4(3) and c4(0);
s6(4)<=s4(4) xor c4(1);
c6(1)<=s4(4) and c4(1);
for i in 5 to 10 loop
s6(i)<=(s4(i) XOR c4(i-3)) XOR s5(i-5);
c6(i-3)<=(s4(i) AND c4(i-3)) OR (s5(i-5)and (s4(i) XOR c4(i-3)));
end loop;
s6(11)<=s4(11) xor s5(6);
c6(8)<=s4(11) and  s5(6);
s6(12)<=s4(12) xor s5(7);
c6(9)<=s4(12) and  s5(7);
s6(14 downto 13)<= s5(9 downto 8);
end process;
-----------calculating s7 and c7
process(s6,c6,c5)
begin
s7(3 downto 0)<= s6(3 downto 0);
for i in 4 to 6 loop
s7(i)<=s6(i) xor c6(i-4);
c7(i-4)<=s6(i) and c6(i-4);
end loop;
for i in 7 to 13 loop
s7(i)<=(s6(i) XOR c6(i-4)) XOR c5(i-7);
c7(i-4)<=(s6(i) AND c6(i-4)) OR (c5(i-7)and (s6(i) XOR c6(i-4)));
end loop;
s7(14)<=s6(14) xor c5(7);
c7(10)<=s6(14) and c5(7);
end process;
anew(14 downto 0)<=s7(14 downto 0);
anew(15)<='0';
bnew(4 downto 0)<="00000";
bnew(15 downto 5)<=c7(10 downto 0);
bit0to7 : ENTITY WORK.bitadder8
	port map (a => anew(7 downto 0),b =>bnew(7 downto 0),cin => '0',sum => ci(7 downto 0), carry=> cn1);
bit8to15 : ENTITY WORK.bitadder8
	port map (a => anew(15 downto 8),b =>bnew(15 downto 8),cin => cn1,sum => ci(15 downto 8), carry=> cn2);
end Behavioral;

