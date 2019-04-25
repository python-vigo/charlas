from scrapy import Spider


class PythonVigoSpider(Spider):
    name = 'python_vigo'
    start_urls = ['https://www.python-vigo.es/']

    def parse(self, response):
        for link in response.css('a[rel="next"]::attr(href)'):
            yield response.follow(link.get(),
                                  callback=self.parse)
        for link in response.css('h1 a::attr(href)'):
            yield response.follow(link.get(),
                                  callback=self.parse_article)

    def parse_article(self, response):
        yield {'name': response.css('h1 *::text').get(),
               'date': response.css('*::attr(datetime)').get(),
               'url': response.url,
               'tags': response.css('a[rel="tag"]::text').getall()}
