.model small
.stack 100h   
.data
screenMatrix db 0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CBh,00Fh,0CBh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0BBh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0D0h,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0B9h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0D0h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0D0h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0B9h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0CCh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0D0h,00Fh,020h,00Fh,020h,00Fh,0CCh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0D0h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0B7h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0B9h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0BBh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0D0h,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0B7h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0B7h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh
             db 0CCh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0B9h,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0CCh,00Fh,0CDh,00Fh,0CDh,00Fh,0B9h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0B7h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0CDh,00Fh,0CDh,00Fh,0B9h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BBh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0B9h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0BCh,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0C9h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0Cdh,00Fh,0Bch,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,0D0h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0CCh,00Fh,0CDh,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,0D0h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0Cdh,00Fh,0CDh,00Fh,0B9h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CAh,00Fh,0CDh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0C8h,00Fh,0BCh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh
             db 0BAh,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh
             db 0CCh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CBh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0B9h,00Fh
             db 0BAh,00Fh,053h,00Fh,063h,00Fh,06Fh,00Fh,072h,00Fh,065h,00Fh,03Ah,00Fh,020h,00Fh,030h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh,020h,00Fh,04Bh,00Fh,06Eh,00Fh,061h,00Fh,07Ah,00Fh,07Ah,00Fh,02Ch,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,04Ch,00Fh,061h,00Fh,062h,00Fh,061h,00Fh,020h,00Fh,034h,00Fh,02Ch,00Fh,046h,00Fh,04Bh,00Fh,053h,00Fh,049h,00Fh,053h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,032h,00Fh,030h,00Fh,031h,00Fh,037h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,020h,00Fh,0BAh,00Fh
             db 0C8h,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0CDh,00Fh,0BCh,00Fh
             
    score dw 0                         ; переменная для хранения кол-ва очков
    score_str db 20 dup(?)             ; строка для конвертации из числа в символы 
    
    game_over_msg db 'G',04Eh,'a',04Eh,'m',04Eh,'e',04Eh,' ',04Eh,'O',04Eh,'v',04Eh,'e',04Eh,'r',04Eh,'!',04Eh
    game_win db 'Y',04Eh,'o',04Eh,'u',04Eh,' ',04Eh,'w',04Eh,'i',04Eh,'n',04Eh,'!',04Eh,'!',04Eh,'!',04Eh
    
    BOT_1 db 00h,00h,00h,00h,02h,07h   ; сам враг 
    PAUSE_1 dw 0                       ; переменная для задержки врага
    
    random db 0                        ; вспомогательная переменная для генератора случайных чисел
    rmin db 0                          ; левая граница интервала для случайных чисел
    rmax db 0                          ; правая граница интервала для случайных чисел
    rand_res dw 0                      ; случайное число 
    
    LEN dw 0                           ; длина сконвертированной строки
    PAUSE dw 0                         ; переменная задержки цикла очков
    
    ; константы соответствующие кодам клавиш
    LEFT   equ 61h                      ; клавиша "A"
    RIGHT  equ 64h                      ; клавиша "D"
    UP     equ 77h                      ; клавиша "W"
    DOWN   equ 73h                      ; клавиша "S"
    EXIT   equ 1bh                      ; клавиша "esc" 
    
    ; константы соответствующие кодам символов
    SPACE equ 20h                       ; символ пробела
    PACMAN  equ 02h                     ; символ пакмана
    POINT equ 06h                       ; символ очка
    ENEMY equ 40h                       ; символ врага
.code 

Rand MACRO min, max                     ; макрос - генератор случайных чисел на основе счетчика времени
    push ax
    push bx
    xor bx, bx
                                       
    mov ah,00h                          ; читаем значение счетчика в cx:dx
    int 1ah 
    xor ax,ax
    mov al,dl                           ; берем то что в dl и делим на (правая граница - левая граница) 
    mov random,max                                       
    sub random,min
    div random
    add ah, min                         ; к остатку от деления прибавляем левую границу
    mov bl,ah 
    mov rand_res,bx
    pop bx
    pop ax    
endm 

start:    
    mov ax, @data
    mov ds,ax 

    mov ah,00                           ; установка видеорежима
    mov al,03
    int 10h 
   
    mov     ah, 1                       ; стирание курсора с игрового поля
    mov     ch, 20h
    int     10h  
                                      
    push 0B800h                         ; помещение видеобуфера в стек
    pop es      
    
    mov cx, 0FA0h
    mov di, 00h                         ; связывание видеобуфера с di
    lea si, screenMatrix                
    cld
    rep movsb  
    
    SPAWN_PACMAN:
    mov bx, 162 
    mov es:[bx], PACMAN
    mov es:[bx+1], 0Eh
START_GAME:    
    mov ah, 00h                         ; ожидание нажатия клавиши
    int 16h
    cmp al, 20h
    je MAIN_CYCLE
    jne START_GAME
    
MAIN_CYCLE:
    xor ax,ax
    mov ah, 01h                         ; проверка буфера клавиатуры, если там пусто то переходи на спавн очков 
  
    int 16h
    jz SCORE_APPEAR

    mov ah, 00h                         ; считывание символа из буфера клавиатуры
    int 16h
    
                                        ; определение какая клавиша была нажата
    cmp al, RIGHT         
    je GO_RIGHT                         ; движение героя направо
    cmp al, LEFT         
    je GO_LEFT                          ; движение героя налево
    cmp al, UP         
    je GO_UP                            ; движение героя вверх
    cmp al, DOWN                       
    je GO_DOWN                          ; движение героя вниз
    cmp al, EXIT         
    je exit_Game                        ; выход из игры
    
SCORE_APPEAR:                           ; спавн очков
    inc PAUSE            
    cmp PAUSE, 7530h                    ; задержка
    jne ENEMY_1
    mov PAUSE, 0
    
    mov ax, 160        
    Rand 1, 20                          ; выбираем случайную строку
    mul rand_res
    Rand 2, 79                          ; случайную ячеку поля
    add ax, rand_res 
    add ax, rand_res
    mov si, ax                          
    
    cmp es:[si], SPACE                  
    jne ENEMY_1                         
    mov es:[si], POINT                  
    mov es:[si+1], 4h   
                           
    
                                        
ENEMY_1:                                
    lea di, BOT_1
    cmp BOT_1[0], 0                     ; в зависимости от значения либо отрисовываем врага либо двигаем
    je ENEMY_1_APPEAR 
    jne ENEMY_1_MOVE
ENEMY_1_APPEAR:     
    call ENEMY_APPEAR
ENEMY_1_MOVE:
    inc PAUSE_1                         ; пауза в движении врага 7 000 циклов
    cmp PAUSE_1, 7000
    jne SCREEN_SCORE     
    call ENEMY_MOVE
    mov PAUSE_1, 0   
 jmp SCREEN_SCORE     
      
GO_RIGHT:
    cmp es:[bx+2], ENEMY
    je exit_Game                  
SCORE_RIGHT:
    cmp es:[bx+2], POINT               
    jne CHECK_RIGHT
    inc score
    jmp MOVE_RIGHT     
CHECK_RIGHT:    
    cmp es:[bx+2], SPACE
    jne ENEMY_1 
MOVE_RIGHT:                             
    mov es:[bx], SPACE
    mov es:[bx+1], 0h 
    add bx, 2
    mov es:[bx], PACMAN
    mov es:[bx+1], 0Eh
    jmp ENEMY_1    
    
GO_LEFT:                             ; движение пакмана налево
    cmp es:[bx-2], ENEMY
    je exit_Game    
SCORE_LEFT: 
    cmp es:[bx-2], POINT
    jne CHECK_LEFT
    inc score
    jmp MOVE_LEFT     
CHECK_LEFT:  
    cmp es:[bx-2], SPACE
    jne ENEMY_1
MOVE_LEFT:    
    mov es:[bx], SPACE
    mov es:[bx+1], 0h 
    sub bx, 2
    mov es:[bx], PACMAN
    mov es:[bx+1], 0Eh
    jmp ENEMY_1  
    
GO_UP:                               ; движение пакмана вверх
    cmp es:[bx-160], ENEMY
    je exit_Game
SCORE_UP:
    cmp es:[bx-160], POINT
    jne CHECK_UP
    inc score
    jmp MOVE_UP     
CHECK_UP: 
    cmp es:[bx-160], SPACE
    jne ENEMY_1   
MOVE_UP:
    mov es:[bx], SPACE
    mov es:[bx+1], 0h
    sub bx, 160
    mov es:[bx], PACMAN
    mov es:[bx+1], 0Eh
    jmp ENEMY_1  
    
GO_DOWN:                             ; движение пакмана вниз
    cmp es:[bx+160], ENEMY
    je exit_Game
SCORE_DOWN:
    cmp es:[bx+160], POINT
    jne CHECK_DOWN
    inc score
    jmp MOVE_DOWN     
CHECK_DOWN:
    cmp es:[bx+160], SPACE
    jne ENEMY_1 
MOVE_DOWN:
    mov es:[bx], SPACE
    mov es:[bx+1], 0h 
    add bx, 160
    mov es:[bx], PACMAN
    mov es:[bx+1], 0Eh
    jmp ENEMY_1
    
SCREEN_SCORE:                           ; отрисовка кол-ва очков игрока на экране
    push bx
    
    lea bx, score
    lea di, score_str
    call iTOstr                        ; преобразование от числа к строке
    
    mov cx, LEN
    mov di, 0E70h
    lea si, score_str
    cld
    rep movsb                          ; отрисовка очков

    pop bx
    cmp score, 009h
    je exit_Game
    jne MAIN_CYCLE 

proc ENEMY_MOVE                          
ENE_MOVE:
    mov ah, 2[di]   
    mov al, 3[di]
    mov si, ax                         
    cmp 1[di], 0                       
    je  ENE_RIGHT                        
    cmp 1[di], 1
    je  ENE_DOWN
    cmp 1[di], 2
    je  ENE_LEFT
    cmp 1[di], 3
    je  ENE_UP 
ENE_RIGHT:
    cmp es:[si+2], PACMAN
    je exit_Game
    cmp es:[si+2], SPACE
    je FINAL_RIGHT
    cmp es:[si+2], POINT
    je FINAL_RIGHT
    jne ENE_CHANGE
FINAL_RIGHT:
    mov es:[si], SPACE
    mov es:[si+1], 0h 
    add si, 2
    mov ah, 4[di]
    mov al, 5[di]
    mov es:[si], ah
    mov es:[si+1], al
    jmp SAVE_POSITION
ENE_DOWN:
    cmp es:[si+160], PACMAN
    je exit_Game
    cmp es:[si+160], SPACE
    je FINAL_DOWN
    cmp es:[si+160], POINT
    je FINAL_DOWN
    jne ENE_CHANGE
FINAL_DOWN:
    mov es:[si], SPACE
    mov es:[si+1], 0h 
    add si, 160
    mov ah, 4[di]
    mov al, 5[di]
    mov es:[si], ah
    mov es:[si+1], al
    jmp SAVE_POSITION
ENE_LEFT:
    cmp es:[si-2], PACMAN
    je exit_Game
    cmp es:[si-2], SPACE
    je FINAL_LEFT
    cmp es:[si-2], POINT
    je FINAL_LEFT
    jne ENE_CHANGE
FINAL_LEFT:
    mov es:[si], SPACE
    mov es:[si+1], 0h 
    sub si, 2
    mov ah, 4[di]
    mov al, 5[di]
    mov es:[si], ah
    mov es:[si+1], al
    jmp SAVE_POSITION
ENE_UP:
    cmp es:[si-160], PACMAN   
    je exit_Game
    cmp es:[si-160], SPACE
    je FINAL_UP
    cmp es:[si-160], POINT
    je FINAL_UP
    jne ENE_CHANGE
FINAL_UP:
    mov es:[si], SPACE
    mov es:[si+1], 0h 
    sub si, 160
    mov ah, 4[di]
    mov al, 5[di]
    mov es:[si], ah
    mov es:[si+1], al
    jmp SAVE_POSITION 
ENE_CHANGE:                             ; случаная смена направления движения врага при встрече с препятствием или другим призраком
    Rand 0, 4
    mov ax, rand_res
    mov 1[di], al     
    jmp ENE_MOVE 
SAVE_POSITION:                          ; сохранение текущей позиции врага
    mov ax,si
    mov 2[di], ah
    mov 3[di], al          
    ret 
endp  
    
proc ENEMY_APPEAR                        
ENEMY_SPAWN:   
    mov ax, 160         
    Rand 1, 23
    mul rand_res
    Rand 2, 63
    add ax, rand_res 
    add ax, rand_res
    mov si, ax 
    
    cmp es:[si], SPACE
    jne ENEMY_SPAWN 
    mov ah, 4[di]
    mov al, 5[di]
    mov es:[si], ah
    mov es:[si+1], al
    
    mov ax,si
    mov 2[di], ah
    mov 3[di], al 
    
    mov [di], 1  
        
    ret
endp
    
    
iTOstr PROC                            ; процедура перевода числа в строку
    push ax
    push bx
    push cx
    push di    

    mov ax, [bx]
    mov bx, 10
    xor cx, cx 
        
division:
    xor dx, dx
    div bx       
    push dx
    inc cx
    cmp ax, 0
    jne division
    
    mov LEN, cx
    add LEN, cx
    
save_in_str:
    pop dx
    add dl, 30h
    mov [di], dl
    inc di  
    mov [di], 00Fh
    inc di
    loop save_in_str    
    
    pop di 
    pop cx
    pop bx
    pop ax
 
    ret
endp     

exit_Game:
    
    mov cx, 14h
    mov di, 724h 
    cmp score, 009h
    je WIN
    jne FAIL
WIN:       
    xor si, si
    lea si, game_win
    cld
    rep movsb
    jmp EXIT_1    
FAIL: 
    xor si,si
    lea si, game_over_msg
    cld
    rep movsb   
EXIT_1:                     
    mov ax, 4ch
    int 21h   

end start
