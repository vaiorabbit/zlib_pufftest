#include <assert.h>
#include <stdio.h>
#include <string.h>

// #include <zlib.h> // for uncompress()

extern "C" {
#include "puff.h"
}

namespace ZLConfig
{
    int ORIG_LENGTH = 8192;
    int COMP_LENGTH = 8300;
}

void decompress( FILE* f_in, FILE* f_out )
{
    unsigned char comp_buf[ZLConfig::COMP_LENGTH];
    unsigned char orig_buf[ZLConfig::ORIG_LENGTH];
    unsigned int orig_size, comp_size;

    fread( &comp_size, sizeof(comp_size), 1, f_in );
    while ( !feof(f_in) && comp_size != 0 )
    {
        fread( comp_buf, comp_size, 1, f_in );

        unsigned long comp_sizeL = comp_size;
        unsigned long orig_sizeL = sizeof(orig_buf);

        int err = puff( orig_buf, &orig_sizeL, comp_buf + 2, &comp_sizeL );
        // int err = uncompress( orig_buf, &orig_sizeL, comp_buf, ZLConfig::COMP_LENGTH ); // uncompress : Zlib API
        assert( err == 0 );

        comp_size = (unsigned int)comp_sizeL;
        orig_size = (unsigned int)orig_sizeL;

        fread( &comp_size, sizeof(comp_size), 1, f_in );
        fwrite( orig_buf, orig_size, 1, f_out );
    }
}

int main( int argc, char** argv )
{
    if ( argc == 2 )
    {
        if ( strstr( argv[1], ".ZL" ) == NULL )
            return 0;

        FILE *f_in, *f_out;
        f_in = fopen( argv[1], "rb" );

        char f_out_filename[1024];
        memset( f_out_filename, '\0', sizeof(f_out_filename) );
        strncpy( f_out_filename, argv[1], strlen(argv[1])-3 );
        strncat( f_out_filename, "\0", strlen("\0") );

        f_in = fopen( argv[1], "r" );
        f_out = fopen( f_out_filename, "w" );

        int original_file_size = 0;
        fread( &original_file_size, sizeof(original_file_size), 1, f_in );

        decompress( f_in, f_out );

        fclose( f_in );
        fclose( f_out );
    }

    return 0;
}
