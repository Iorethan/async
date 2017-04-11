""" Rest client for async tasks """
import RestClient
from kivy.uix.widget import Widget
from kivy.properties import StringProperty

class AsyncScreen(Widget):
    """ Main screen widget """
    languages = StringProperty("Click on one of the buttons")
    client = None

    def __init__(self, **kwargs):
        super(AsyncScreen, self).__init__(**kwargs)
        self.client = RestClient.RestClient(self)

    def get_button_handler(self):
        """ Handler for get button """
        self.languages = "Waiting for response from server..."
        self.client.get()

    def post_button_handler(self):
        """ Handler for post button """
        self.languages = "Waiting for response from server..."
        self.client.post()
