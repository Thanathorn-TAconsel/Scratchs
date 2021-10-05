Class

Main(Scratchs)
	เป็น Class Main หลักและใช้สร้างหรือเรียก Class อื่นๆตาม Event ต่างๆ mouse LEFT mouse RIGHT มี Method redraw() ในการวาดทุกองค์ประกอบโดยโปรแกรมนี้จะ clear background(0) ก่อน และวาด Class ทั้งหมด ตัวแปรทุกตัวที่เป็นแบบ Global จะถูกเก็บไว้ใน Class นี้ โดยใช้ HashMap<String, String> และเก็บ Class อื่นที่ถูกสร้างขึ้นมาไว้ใน  ArrayList<command> โดยจะเก็บเฉพาะ Root และให้ Tree ตัวนั้นมี Class Child ต่อไปอย่างอิสระ แต่ถ้า Root ตัวนั้นถูกลบ Class Child ทั้งหมดใน Tree นั้นก็จะถูกลบไปด้วย

MyCat
	เป็น Class ที่ใช้วาดตัวแมว (Sprite) และมีคำสั่ง move (String direction ,float amount) ในการขยับตัวละคร รวมถึงมีคำสั่ง Rotate ในการหมุนและคำสั่ง draws() ในการวาดตัวละคร

command
	เป็น class ที่เป็น super class ที่จะเก็บ Method หลักๆไว้ที่จะถูก overide

If-else extends command
	เป็น Class เงื่อนไขแบบ if - else โดยจะมี Class ที่เก็บไว้คือ test yes no next โดยที่ Class test จะใช้สำหรับทดสอบเงื่อนไข โดยจะเรียก method test.action() จะคืนค่าเป็น 0 เมื่อเป็จเท็จและ เป็นจริงเมื่อมีค่ามากกว่า 0 
เมื่อคำสั่งเป็นจริงจะทำการเรียก class yes.action() และ Class yes ก็จะทำงานต่อไปและเรียก Child ของ Class yes ต่อไปจนหมด หลังจากกนั้น class next ก็จะถูกเรียกต่อไปยัง Child ถ้าเป็นเท็จจะเรียก Class no

While extends command
	เป็น Class loop โดยจะมี Class ที่เก็บไว้คือ test yes next ถ้าทดสอบ class test แล้วเป็นจริงจะเรียก class yes และกลับมาเช็ค test อีกจนกว่า test จะเป็น false (Class yes อาจมี Child ที่ถูกเรียกหลังจาก yes.action()) หลังจากนั้นจะเรียก class next.action() เพื่อจบการทำงานของ while





Number extends command
	เป็น Class ที่จะคืนค่าเป็นตัวเลขที่ถูกกำหนดไว้โดยการคลิกขวา (เดิมเป็นการคลิกขวา อาจเปลื่ยนเป็นการคลิกซ้าย) โดย method action() จะคืนค่าตัวเลขที่ได้ถูกตั้งค่าไว้และเรียก class Child ของมันต่อไป

SetVar extends command
	เป็น Class มี class vts (var to set) กับ stv (set to var) ทำหน้าที่กำหนดค่าของตัวแปร โดยจะนำตัวแปรจาก class stv ที่เป็น class variable หรือ class number มา set value ให้กับ vts

Variable extends command
	เป็น Class ที่ใช้เชื่อมโยงกับชื่อตัวแปรกับค่าของตัวแปรที่เป็นแบบ Global  สามารถ set ค่าและ get ค่าได้และจะมี class child เพื่อสามารถที่จะนำ Class อื่นๆ มาต่อจากตัวมันได้

Comparator extends command
	เป็น Class ที่มี class A และ B เพื่อใช้ในการเปรียบเทียบ โดยมีโหมดการทำงานเป็น ==, !=,<=, >= ,<, > ตามที่ได้ตั้งไว้โดยการคลิกขวา(คลิกขวาเพื่อเปลี่ยนเครื่องหมาย) การทำงานจะเปรียบเทียบ A กับ B และจะคืนค่าเป็น 1 เมื่อเป็นจริง และ 0 เมื่อเป็นเท็จ

Operator extends command
	เป็น class คำนวนค่า + - * / โดยสามารถเลือกโหมดการคำนวนโดยการคลิกขวา โดยจะเก็บ Class ไว้สอง Class คือ A,B เช่นการจะคืนค่า A + B หลังจาก Method action() ถูกเรียก หรืออื่นๆตามโหมดที่ได้ตั้งไว้

Move extends command
	เป็น class ใช้สำหรับขยับตัวละครตาม Class ที่ได้กำหนดไว้คือ movetovar ซึ่ง class ที่ถูกใส่เข้ามาจะต้องคืนค่ามาเป็นตัวเลขเช่น Variable หรือ Number

Delay extends command
	ใช้หน่วงเวลาคำสั่งแต่ละคำสั่งตามตัวแปรหรือตัวเลขที่ได้นำมาใส่ไว้


สิ่งที่ต้องเพิ่ม
เพิ่มหน้าจอสำหรับแสดงค่า Text บน Scatch โดยใช้คำสั่ง print จะต้องสร้างตัวแปร เพื่อมาเก็บค่าเดิมก่อน จากนั้นค่อย draws text ขึ้นไปที่หน้าจอ
เปลี่ยนการกำหนดค่า Variable จากคลิกขวาเป็นคลิกซ้ายแล้วมีตัวเลือกให้เลือกได้ โดยมีให้เลือก rename 
แสดงค่าตำแหน่งของรูปแมวบนหน้าจอ Scatch 




