/*
 * Convert DEVICE_ATTR() macro to DEVICE_ATTR_WO()
 * wherver applicable.
 */

@r@
identifier attr, store_fn;
declarer name DEVICE_ATTR;
@@

DEVICE_ATTR(attr, \(S_IWUSR\|0200\), NULL, store_fn);

@script: python p@
attr_store;
attr << r.attr;
@@

// standardise the store fn name to {attr}_store
coccinelle.attr_store = attr + "_store"

@@
identifier r.attr, r.store_fn;
declarer name DEVICE_ATTR_WO;
@@

// change the attr declaration
- DEVICE_ATTR(attr, \(S_IWUSR\|0200\), NULL, store_fn);
+ DEVICE_ATTR_WO(attr);

@rr@
identifier r.store_fn, p.attr_store;
@@

// rename the store function
- store_fn
+ attr_store
	(...) {
	...
	}

@depends on rr@
identifier r.store_fn, p.attr_store;
@@

// rename fn usages
- store_fn
+ attr_store
