using System.Windows;

namespace wpf
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public LanguagesViewModel LanguagesViewModel { get; set; } = new LanguagesViewModel();
        public MainWindow()
        {
            InitializeComponent();
            this.DataContext = LanguagesViewModel;
        }
    }
}
