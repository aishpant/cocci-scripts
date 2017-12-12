/*
 * Convert DEVICE_ATTR() macro to DEVICE_ATTR_RO()
 * wherever applicable. Unlike the other script, this
 * does not rename functions and is safer to use.
 */

@r@
identifier attr, show_fn;
declarer name DEVICE_ATTR;
@@

DEVICE_ATTR(attr, \(S_IRUGO\|0444\), show_fn, NULL);

@script: python p@
attr << r.attr;
show_fn << r.show_fn;
@@

if (attr + "_show" != show_fn):
	cocci.include_match(False)

@@
identifier r.attr, r.show_fn;
declarer name DEVICE_ATTR_RO;
@@

// change the attr declaration
- DEVICE_ATTR(attr, \(S_IRUGO\|0444\), show_fn, NULL);
+ DEVICE_ATTR_RO(attr);
