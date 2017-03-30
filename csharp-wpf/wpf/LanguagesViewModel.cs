using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Dynamic;
using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using async;
using Prism.Commands;

namespace wpf
{
    public class LanguagesViewModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        private ObservableCollection<string> _languages = new ObservableCollection<string>();
        public ObservableCollection<string> Languages {
            get { return _languages; }
            set
            {
                _languages = value;
                OnPropertyChanged("Languages");
            } }
        private bool _ongoingDownload = false;
        public bool CanDownload
        {
            get { return !_ongoingDownload; }
            set
            {
                _ongoingDownload = !value;
                OnPropertyChanged("CanDownload");
            }
        }
        public ICommand LoadData { get; set; }

        public LanguagesViewModel()
        {
            LoadData = new DelegateCommand(DownloadData, CanExecuteDownload);
        }

        public void DownloadData()
        {
            CanDownload = false;
            GetLangueges();
            Languages = new ObservableCollection<string>() { "Loading" }; // demostrates responsivnes of gui with ongoing Task
        }

        public bool CanExecuteDownload()
        {
            return CanDownload;
        }

        public async Task GetLangueges()
        {
            var dowloader = new AsynchronousDowloader();
            var json = await dowloader.Get("http://private-9d572-asynchronoustasks.apiary-mock.com/basic");
            var langueges = new Parser().Parse(json).Languages;
            Thread.Sleep(2000); // simulates noticable delay
            Languages.Clear();
            foreach (var languege in langueges)
            {
                Languages.Add(languege);
            }
            CanDownload = true;
        }

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
