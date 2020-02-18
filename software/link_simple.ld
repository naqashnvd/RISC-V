/*
	simple link script for risac
*/

ENTRY(_start)

MEMORY 
{
	RAM (rwx): ORIGIN = 0x0, LENGTH = 4K
}

/* stack pointer is the highest stack address */
PROVIDE(_stack_pointer = ORIGIN(RAM) + LENGTH(RAM));
PROVIDE( __global_pointer$ = (4K / 2) );

SECTIONS
{
	.text : 
	{
		*(.text.init)
		*(.text)
		*(.text.*)
	} 

	. = ALIGN(4);

	.rodata :
	{
		*(.data)
		*(.data.*)
	} > RAM

	. = ALIGN(4);

	.bss : 
	{
		*(.bss)
		*(.bss.*)
		*(COMMON)
	} > RAM 
}
