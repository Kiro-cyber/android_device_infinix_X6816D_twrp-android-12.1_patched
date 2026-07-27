#!/sbin/sh

# TOUCH FIX
load_panel()

{
	insmod /lib/modules/gpio.ko
	insmod /lib/modules/gpio-sprd.ko
	insmod /lib/modules/sprd-drm.ko
	insmod /lib/modules/tran_hwinfo.ko
	insmod /lib/modules/sensorhub.ko
	insmod /lib/modules/adaptive-ts.ko
	insmod /lib/modules/ssd20xx_ts.ko
	# Some X6816D/X6816D-RU panel revisions use a Synaptics controller
	# instead of the ssd20xx one above. Loading it too is harmless if
	# the chip isn't present (probe just fails) but fixes touch on
	# units with the other panel variant. Check dmesg for which one
	# actually attaches (look for "input: ..." probe success lines).
	insmod /lib/modules/synaptics_dsx_td4310.ko
	log -t load_modules "touch modules load attempt finished, check dmesg for probe results"
	insmod /lib/modules/sc27xx-vibra.ko
	insmod /lib/modules/thermal-generic-adc.ko
	insmod /lib/modules/sc27xx_tsensor_thermal.ko
	insmod /lib/modules/kfifo_buf.ko
}


load_panel
wait 1
setprop modules.loaded 1
exit 0