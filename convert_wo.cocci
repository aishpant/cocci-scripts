/*
 * Convert DEVICE_ATTR() macro to DEVICE_ATTR_WO()
 * wherever applicable. Unlike the other script, this
 * does not rename functions and is safer to use.
 */

@r@
identifier attr, store_fn;
declarer name DEVICE_ATTR;
@@

DEVICE_ATTR(attr, \(S_IWUSR\|0200\), NULL, store_fn);

@script: python p@
attr << r.attr;
store_fn << r.store_fn;
@@

if (attr + "_store" != store_fn):
	cocci.include_match(False)

@@
identifier r.attr, r.store_fn;
declarer name DEVICE_ATTR_RO;
@@

// change the attr declaration
- DEVICE_ATTR(attr, \(S_IWUSR\|0200\), NULL, store_fn);
+ DEVICE_ATTR_RO(attr);

