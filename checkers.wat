(module
    (memory $mem 1)

    ;; Determine the byte offset for a given X and Y coordinate
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
)