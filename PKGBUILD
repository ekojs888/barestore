pkgname=barestore
pkgver=1.0
pkgrel=1
pkgdesc="Barestore backup tool"
arch=('x86_64')
url="https://github.com/ekojs888/barestore.git"
license=('GPL')
depends=()
source=("barestore" "barestore.conf" "README")
sha256sums=('SKIP' 'SKIP' 'SKIP')

package() {
    # binary
    install -Dm755 "$srcdir/barestore" "$pkgdir/usr/bin/barestore"

    # config default
    install -Dm644 "$srcdir/barestore.conf" "$pkgdir/etc/barestore.conf"

    # documentation
    install -Dm644 "$srcdir/README" "$pkgdir/usr/share/doc/$pkgname/README"

    # backup folder (misalnya butuh default directory)
    install -d "$pkgdir/var/lib/barestore"
}

