""" python3 URL request lib """
import kivy.network.urlrequest
from kivy.properties import StringProperty


class RestClient():
    """ Rest client """
    url = "https://private-9d572-asynchronoustasks.apiary-mock.com/basic"
    async_screen = None

    def __init__(self, async_screen):
        self.async_screen = async_screen

    def get(self):
        """ Get languages by GET HTTP method """
        headers = {'Content-Type': 'application/json'}
        kivy.network.urlrequest.UrlRequest(self.url,
                                           on_success=self.parse_response, req_headers=headers)

    def post(self):
        """ Get languages by POST HTTP method """
        post_request = """
                        {
                            "_session": "demo",
                            "credentials": {
                            "username": "demo",
                            "password": "demo"
                            }
                        }
                        """
        binary_data = post_request.encode('UTF-8')
        headers = {'Content-Type': 'application/json'}
        kivy.network.urlrequest.UrlRequest(self.url, on_success=self.parse_response,
                                           req_body=binary_data, req_headers=headers)

    def parse_response(self, req, result):
        """ Async handler """
        languages = ""
        for language in result['supported']:
            languages += language + ", "
        self.async_screen.languages = languages
    