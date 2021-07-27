(module
    (memory $mem 1)

    ;; Game State Globals
    (global $WHITE i32 (i32.const 2))
    (global $BLACK i32 (i32.const 1))
    (global $CROWN i32 (i32.const 4))

    ;; game state meaning in bits
    ;; Binary Value                   Decimal Value    Game Meaning
    ;; [unused 24 bits]...00000000       0          Unoccupied Square
    ;; [unused 24 bits]...00000001       1           Black Piece
    ;; [unused 24 bits]...00000010       2           White Piece
    ;; [unused 24 bits]...00000100       4           Crowned Piece

    ;; Determine the byte offset for a given X and Y cartesian coordinate
    (func $indexForPosition (param $x i32) (param $y i32) (result i32)
        (i32.add
            (i32.mul
                (i32.const 8)
                (get_local $y)
            )
            (get_local $x)
        )
    )
    ;; Offset = ( x + y * 8 ) * 4
    ;; Determine unit position in linear memory of X,Y position of i32s
    ;; i32s occupy 4 bytes of space
    (func $offsetForPosition (param $x i32) (param $y i32) (result i32)
        (i32.mul 
            (call $indexForPosition (get_local $x) (get_local $y))
            (i32.const 4)
        )
    )

    ;; Determine if a piece is white
    (func isWhite (param $piece i32) (result i32)
        (i32.eq
            (i32.and (get_local $piece) (get_global $WHITE))
            (get_global $WHITE)
        )
    )

    ;; Determine if a piece is black
    (func $isBlack (param $piece i32) (result i32)
        (i32.eq
            (i32.and (get_local $piece) (get_global $BLACK))
            (get_global $BLACK)
        )
    )

    ;; Determine if a piece has been crowned
    (func $isCrowned (param $piece i32) (result i32)
        (i32.eq
            (i32.and (get_local $piece) (get_global $CROWN))
            (get_global $CROWN)
        )
    )

    ;; Adds a crown to a given piece (no mutation)
    (func $withCrown (param $piece i32) (result i32)
        (i32.or (get_local $piece) (get_global $CROWN))
    )

    ;; Removes a crown from a given piece (no mutation)
    (func $withoutCrown (param $piece i32) (result i32)
        (i32.and (get_local $piece) (i32.const 3))
    )
)