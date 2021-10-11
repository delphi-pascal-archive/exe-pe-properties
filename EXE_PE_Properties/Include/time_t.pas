function UnixTimeToFileTime(t:LongWord):FILETIME;
var ll:int64;
begin
     ll := (Int64(t) * 10000000) + int64(116444736000000000);
     result.dwLowDateTime := LongWord(ll);
     result.dwHighDateTime := ll shr 32;
end;

