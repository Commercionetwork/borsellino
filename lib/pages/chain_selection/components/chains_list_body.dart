import 'package:borsellino/constants/constants.dart';
import 'package:borsellino/models/models.dart';
import 'package:flutter/material.dart';

typedef void ChainSelectionCallback(ChainInfo chain);

class ChainListBody extends StatefulWidget {
  final List<ChainInfo> chains;
  final ChainSelectionCallback callback;

  ChainListBody({
    @required this.chains,
    @required this.callback,
  })  : assert(chains != null),
        assert(callback != null);

  @override
  _ChainListBodyState createState() => _ChainListBodyState();
}

class _ChainListBodyState extends State<ChainListBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.chains.length,
      itemBuilder: (context, index) {
        final ChainInfo chain = widget.chains[index];

        return InkWell(
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: _buildIcon(chain),
            title: Text(chain.name),
          ),
          onTap: () => widget.callback(chain),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 0),
    );
  }

  Widget _buildIcon(ChainInfo chain) {
    return Image.network(chain.iconUrl ?? DEFAULT_CHAIN_IMAGE_URL);
  }
}
