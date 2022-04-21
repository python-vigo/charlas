import json


def load_json(filename):
    with open(filename) as f:
        return json.load(f)


def load_ndjson(filename):
    with open(filename) as f:
        while True:
            line = f.readline()
            if not line:
                # NOTE: no soportamos lineas vacias entre medias
                break

            try:
                yield json.loads(line)
            except json.JSONDecodeError as ex:
                yield ex


def main():
    from_json = load_json("ejemplo.json")
    print("from json:", from_json)

    print("from ndjson:")
    for i, obj in enumerate(load_ndjson("ejemplo.ndjson")):
        print(i, obj)


if __name__ == '__main__':
    main()
