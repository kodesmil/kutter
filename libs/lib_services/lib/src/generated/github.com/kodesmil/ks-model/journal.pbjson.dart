///
//  Generated code. Do not modify.
//  source: github.com/kodesmil/ks-model/journal.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const JournalSubject$json = const {
  '1': 'JournalSubject',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.atlas.rpc.Identifier', '8': const {}, '10': 'id'},
    const {'1': 'key', '3': 2, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.model.JournalSubject.Type', '10': 'type'},
  ],
  '4': const [JournalSubject_Type$json],
  '7': const {},
};

const JournalSubject_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'ACTIVITY', '2': 0},
    const {'1': 'SYMPTOM', '2': 1},
  ],
};

const JournalEntry$json = const {
  '1': 'JournalEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.atlas.rpc.Identifier', '8': const {}, '10': 'id'},
    const {'1': 'severity', '3': 2, '4': 1, '5': 14, '6': '.model.JournalEntry.Severity', '10': 'severity'},
    const {'1': 'note', '3': 3, '4': 1, '5': 9, '10': 'note'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'journal_subject_id', '3': 5, '4': 1, '5': 3, '10': 'journalSubjectId'},
  ],
  '4': const [JournalEntry_Severity$json],
  '7': const {},
};

const JournalEntry_Severity$json = const {
  '1': 'Severity',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'LOW', '2': 1},
    const {'1': 'MID', '2': 2},
    const {'1': 'HIGH', '2': 3},
  ],
};

const CreateJournalEntryRequest$json = const {
  '1': 'CreateJournalEntryRequest',
  '2': const [
    const {'1': 'payload', '3': 1, '4': 1, '5': 11, '6': '.model.JournalEntry', '10': 'payload'},
  ],
};

const CreateJournalEntryResponse$json = const {
  '1': 'CreateJournalEntryResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.model.JournalEntry', '10': 'result'},
  ],
};

const ReadJournalEntryRequest$json = const {
  '1': 'ReadJournalEntryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.atlas.rpc.Identifier', '10': 'id'},
  ],
};

const ReadJournalEntryResponse$json = const {
  '1': 'ReadJournalEntryResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.model.JournalEntry', '10': 'result'},
  ],
};

const UpdateJournalEntryRequest$json = const {
  '1': 'UpdateJournalEntryRequest',
  '2': const [
    const {'1': 'payload', '3': 1, '4': 1, '5': 11, '6': '.model.JournalEntry', '10': 'payload'},
  ],
};

const UpdateJournalEntryResponse$json = const {
  '1': 'UpdateJournalEntryResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.model.JournalEntry', '10': 'result'},
  ],
};

const DeleteJournalEntryRequest$json = const {
  '1': 'DeleteJournalEntryRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.atlas.rpc.Identifier', '10': 'id'},
  ],
};

const DeleteJournalEntryResponse$json = const {
  '1': 'DeleteJournalEntryResponse',
};

const ListJournalEntryRequest$json = const {
  '1': 'ListJournalEntryRequest',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.infoblox.api.Filtering', '10': 'filter'},
    const {'1': 'order_by', '3': 2, '4': 1, '5': 11, '6': '.infoblox.api.Sorting', '10': 'orderBy'},
    const {'1': 'fields', '3': 3, '4': 1, '5': 11, '6': '.infoblox.api.FieldSelection', '10': 'fields'},
    const {'1': 'paging', '3': 4, '4': 1, '5': 11, '6': '.infoblox.api.Pagination', '10': 'paging'},
  ],
};

const ListJournalEntryResponse$json = const {
  '1': 'ListJournalEntryResponse',
  '2': const [
    const {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.model.JournalEntry', '10': 'results'},
  ],
};

const ListJournalSubjectRequest$json = const {
  '1': 'ListJournalSubjectRequest',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.infoblox.api.Filtering', '10': 'filter'},
    const {'1': 'order_by', '3': 2, '4': 1, '5': 11, '6': '.infoblox.api.Sorting', '10': 'orderBy'},
    const {'1': 'fields', '3': 3, '4': 1, '5': 11, '6': '.infoblox.api.FieldSelection', '10': 'fields'},
    const {'1': 'paging', '3': 4, '4': 1, '5': 11, '6': '.infoblox.api.Pagination', '10': 'paging'},
  ],
};

const ListJournalSubjectResponse$json = const {
  '1': 'ListJournalSubjectResponse',
  '2': const [
    const {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.model.JournalSubject', '10': 'results'},
  ],
};

