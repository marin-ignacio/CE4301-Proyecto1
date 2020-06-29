transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Inspiron\ 14-7460/Desktop/CE4301-Proyecto1/modules/BankRegisterArray {C:/Users/Inspiron 14-7460/Desktop/CE4301-Proyecto1/modules/BankRegisterArray/bankRegisterArray.sv}
vlog -sv -work work +incdir+C:/Users/Inspiron\ 14-7460/Desktop/CE4301-Proyecto1/modules/BankRegisterArray {C:/Users/Inspiron 14-7460/Desktop/CE4301-Proyecto1/modules/BankRegisterArray/TB_bankRegisterArray.sv}

