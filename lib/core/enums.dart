enum GroupSortType {
  album,
  albumArtist,
  year,
  artistsList,
  genresList,
  dateModified,
  composer,
  duration,
  numberOfTracks,
}

enum SortType {
  title,
  album,
  albumArtist,
  year,
  artistsList,
  genresList,
  dateAdded,
  dateModified,
  bitrate,
  composer,
  discNo,
  displayName,
  duration,
  sampleRate,
  size,
}

enum TrackTilePosition {
  row1Item1,
  row1Item2,
  row1Item3,
  row2Item1,
  row2Item2,
  row2Item3,
  row3Item1,
  row3Item2,
  row3Item3,
  rightItem1,
  rightItem2,
  rightItem3,
}

enum TrackTileItem {
  none,
  title,
  album,
  artists,
  albumArtist,
  genres,
  composer,
  trackNumber,
  discNumber,
  duration,
  year,
  size,
  dateAdded,
  dateModified,
  dateModifiedDate,
  dateModifiedClock,
  path,
  folder,
  fileName,
  fileNameWOExt,
  extension,
  comment,
  bitrate,
  sampleRate,
  format,
  channels,
}

enum TrackSearchFilter {
  title,
  album,
  artist,
  albumartist,
  genre,
  composer,
  year,
}

// enum TrackSearchFilter {
//   title,
//   album,
//   artists,
//   albumArtist,
//   genres,
//   composer,
//   year,
// }

enum LibraryTab {
  tracks,
  albums,
  artists,
  genres,
  folders,
}
