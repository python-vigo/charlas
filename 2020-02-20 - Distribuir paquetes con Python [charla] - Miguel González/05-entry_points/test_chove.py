import json

from chove import parse_date, parse_forecast


def test():
    payload = b'{"predConcello":{"idConcello":36057,"listaPredDiaConcello":[{"ceo":{"manha":110,"noite":208,"tarde":117},"dataPredicion":"2020-02-16T00:00:00","pchoiva":{"manha":60,"noite":80,"tarde":80},"tMax":17,"tMin":14,"vento":{"manha":313,"noite":314,"tarde":314}},{"ceo":{"manha":103,"noite":203,"tarde":103},"dataPredicion":"2020-02-17T00:00:00","pchoiva":{"manha":40,"noite":10,"tarde":10},"tMax":14,"tMin":11,"vento":{"manha":316,"noite":304,"tarde":316}},{"ceo":{"manha":103,"noite":201,"tarde":103},"dataPredicion":"2020-02-18T00:00:00","pchoiva":{"manha":10,"noite":5,"tarde":10},"tMax":14,"tMin":4,"vento":{"manha":300,"noite":302,"tarde":300}},{"ceo":{"manha":101,"noite":201,"tarde":102},"dataPredicion":"2020-02-19T00:00:00","pchoiva":{"manha":5,"noite":5,"tarde":5},"tMax":18,"tMin":5,"vento":{"manha":303,"noite":304,"tarde":307}}],"nome":"Vigo"}}'
    data = json.loads(payload)
    print(parse_date(data["predConcello"]["listaPredDiaConcello"][0]["dataPredicion"]))
    print(parse_forecast(data["predConcello"]["listaPredDiaConcello"][0]["pchoiva"]))


if __name__ == "__main__":
    test()
