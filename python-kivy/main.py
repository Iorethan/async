""" Importing Kivy GUI framework """
import kivy
from kivy.app import App
import AsyncScreen
kivy.require('1.9.1')

class AsyncApp(App):
    """ Kivy application """
    def build(self):
        return AsyncScreen.AsyncScreen()

if __name__ == '__main__':
    AsyncApp().run()
