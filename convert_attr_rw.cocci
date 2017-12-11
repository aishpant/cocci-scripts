/*
 * Convert DEVICE_ATTR() macro to DEVICE_ATTR_RW()
 * wherever applicable.
 */

@r@
identifier attr, show_fn, store_fn;
declarer name DEVICE_ATTR;
@@

DEVICE_ATTR(attr, \((S_IRUGO | S_IWUSR)\|0644\), show_fn, store_fn);

@script: python p@
attr_show;
attr_store;
attr << r.attr;
@@

// standardise the fn names to {attr}_(show/store)
coccinelle.attr_show = attr + "_show"
coccinelle.attr_store = attr + "_store"

@@
identifier r.attr, r.store_fn, r.show_fn;
declarer name DEVICE_ATTR_RW;
@@

// change the attr declaration
- DEVICE_ATTR(attr, \((S_IRUGO | S_IWUSR)\|0644\), show_fn, store_fn);
+ DEVICE_ATTR_RW(attr);

@@
identifier r.show_fn, p.attr_show;
@@

// rename the show function
- show_fn
+ attr_show
	(...) {
	...
	}

@@
identifier r.store_fn, p.attr_store;
@@

// rename the store function
- store_fn
+ attr_store
	(...) {
	...
	}
