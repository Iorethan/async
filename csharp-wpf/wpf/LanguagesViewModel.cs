using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
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
                OnPropertyChanged();
            } }
        private bool _ongoingDownload;
        public bool CanDownload
        {
            get { return !_ongoingDownload; }
            set
            {
                _ongoingDownload = !value;
                OnPropertyChanged();
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
            var languages = new Parser().Parse(json).Languages;
            Languages.Clear();
            foreach (var language in languages)
            {
                Languages.Add(language);
            }
            CanDownload = true;
        }

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
