package handler

type Channel struct {
	ID    uint
	Name  string
	URL   string
	M3U8  string
	Quality  string
	Proxy bool
}

type Config struct {
	BaseURL string
	Cmd     string
	Args    string
}
