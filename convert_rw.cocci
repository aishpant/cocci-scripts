/*
 * Convert DEVICE_ATTR() macro to DEVICE_ATTR_RW()
 * wherever applicable. Unlike the other script, this
 * does not rename functions and is safer to use.
 */

@r@
identifier attr, show_fn, store_fn;
declarer name DEVICE_ATTR;
@@

DEVICE_ATTR(attr, \((S_IRUGO | S_IWUSR)\|0644\), show_fn, store_fn);

@script: python p@
show_fn << r.show_fn;
store_fn << r.store_fn;
attr << r.attr;
@@

if ((attr + "_store" != store_fn) and (attr + "_show" != show_fn)):
	cocci.include_match(False)

@@
identifier r.attr, r.store_fn, r.show_fn;
declarer name DEVICE_ATTR_RW;
@@

// change the attr declaration
- DEVICE_ATTR(attr, \((S_IRUGO | S_IWUSR)\|0644\), show_fn, store_fn);
+ DEVICE_ATTR_RW(attr);
