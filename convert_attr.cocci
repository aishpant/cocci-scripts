/*
 * Convert raw __ATTR(...) macro calls to DEVICE_ATTR(...)
 * Applicable for driver source files.
 */

@r@
identifier foo, n;
@@

struct device_attribute foo =  __ATTR(n, ...);

@script:python p@
id;
foo << r.foo;
n << r.n;
@@

// standardise the variable name to dev_attr_{name}
coccinelle.id = "dev_attr_" + n

@@
identifier r.foo;
declarer name DEVICE_ATTR;
@@

//change definition
- struct device_attribute foo = __ATTR
+ DEVICE_ATTR
	(...);

@depends on r@
identifier r.foo, p.id;
@@

// replace usages everywhere
- foo
+ id
