# ndjson / json lines

## Partiendo de...

JSON cuya raíz es un array

```json
[
  {"id":  1, "name":  "foo", "enabled":  true},
  {"id":  2, "name":  "bar", "enabled":  false},
  {"id":  3, "name":  "baz", "enabled":  true},
  {"id":  4, "name":  "baa", "enabled":  false}
]
```

## ...convierto en...

ndjson/jsonlines con cada elemento del array original en una línea

```json lines
{"id":  1, "name":  "foo", "enabled":  true}
{"id":  2, "name":  "bar", "enabled":  false}
{"id":  3, "name":  "baz", "enabled":  true}
{"id":  4, "name":  "baa", "enabled":  false}
```

## Ventajas

- Más eficiente (sobre todo con grandes cantidades de objetos)
  - No cargar todo el json en memoria
  - Validación e iteración línea a línea
- Apto para streaming (leer y procesar línea a línea)

## Desventajas

- Solo apto cuando el objeto raíz del JSON es un array

## Anotaciones

- En teoría se puede utilizar cualquier tipo de objeto json soportado (no sólo objetos como tal)
- Diferencias ndjson vs jsonlines? https://github.com/ndjson/ndjson.github.io/issues/1

## Links

- http://ndjson.org/
- https://github.com/ndjson
- https://jsonlines.org/
