ALL: neobundle link

neobundle:
		mkdir -p ~/.vim/bundle
		git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

link:
		ln -s ~/.vim/vimrc ~/.vimrc
